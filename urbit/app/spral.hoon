/+  *server, default-agent, hod=hodash
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/spral/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/spral/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/spral/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/spral/css/index
  /|  /css/
      /~  ~
  ==
/=  spral-png
  /^  (map knot @)
  /:  /===/app/spral/img  /_  /png/
::
|%
+$  card  card:agent:gall
+$  state-zero  $:  hon=json  con=@ud  ==
++  jsonify
  |=  a=state-zero
  ^-  json
  =,  enjs:format
  %-  pairs
  ~[['hon' hon.a] ['con' (numb con.a)]]
++  hon-jsonify
  |=  a=json
  ^-  json
  =,  enjs:format
  (frond 'hon' a)
++  con-jsonify
  |=  a=@ud
  ^-  json
  =,  enjs:format
  (frond 'con' (numb a))
--
=|  state-zero
=*  state  -
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this       .
      spral-core  +>
      cc         ~(. spral-core bol)
      def        ~(. (default-agent this %|) bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    =/  launcha  [%launch-action !>([%spral /tile '/~spral/js/tile.js'])]
    ^-  (quip card _this)
    =/  p  /[(scot %p our.bol)]/home/[(scot %da now.bol)]
    =/  rom  .^((list path) %ct p)
    =/  j  (paths-to-json:hod rom)
    :_  this(state ^-(state-zero [hon=j con=0]))
    :~  [%pass /spral %agent [our.bol %spral] %watch /spral]
        [%pass / %arvo %e %connect [~ /'~spral'] %spral]
        [%pass /spral %agent [our.bol %launch] %poke launcha]
    ==
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    ?+    mark  :-  [%give %fact `/primary %json !>((con-jsonify +(con)))]~
          this(con +(con))
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      :_  this
      %+  give-simple-payload:app  eyre-id
      %+  require-authorization:app  inbound-request
      poke-handle-http-request:cc
    ::
    ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card:agent:gall _this)
    ?:  ?=([%http-response *] path)
      `this
    ?+  path  (on-watch:def path)
      [%primary *]
    [[%give %fact ~ %json !>((jsonify state))]~ this]
      [%tile *]
    [[%give %fact ~ %json !>(*json)]~ this]
    ==
  ::
  ++  on-agent  on-agent:def
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    [~ this]
  ::
  ++  on-save  on-save:def
  ++  on-load
    |=  old=vase
    ^-  (quip card _this)
    =/  p  /[(scot %p our.bol)]/home/[(scot %da now.bol)]
    =/  rom  .^((list path) %ct p)
    =/  j  (paths-to-json:hod rom)
    `this(state ^-(state-zero [hon=j con=0]))
  ++  on-leave  on-leave:def
  ++  on-peek
    |=  p=path
    ^-  (unit (unit cage))
    ?+  p  (on-peek:def p)
        [%x %hon ~]
        ``[%json !>(hon)]
        [%x %con ~]
        ``[%atom !>(con.state)]
        [%x %state ~]
        ``[%json !>((jsonify state))]
    ==
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall

++  poke-request-file
  |=  p=path q=wire
  ^- card
  [%pass q %arvo %c %warp our.bowl %home ~ %next %x da+now.bowl /sys]
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~spral' %css %index ~]  (css-response:gen style)
      [%'~spral' %js %tile ~]    (js-response:gen tile-js)
      [%'~spral' %js %index ~]   (js-response:gen script)
  ::
      [%'~spral' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by spral-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~spral' *]  (html-response:gen index)
  ==
::
--
