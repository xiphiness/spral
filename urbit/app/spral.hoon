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
+$  state-zero
  $:  fil=(map path mime)
      hon=json
  ==
++  jsonify
  |=  a=state-zero
  ^-  json
  =,  enjs:format
  %+  frond  'initial'
  %+  frond  'hon'  hon.a
--
:: ++  hon-jsonify
::   |=  a=json
::   ^-  json
::   =,  enjs:format
::   (frond 'hon' a)
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
    :_  this(hon j)
    :~  [%pass /spral %agent [our.bol %spral] %watch /spral]
        [%pass / %arvo %e %connect [~ /'~spral'] %spral]
        [%pass /spral %agent [our.bol %launch] %poke launcha]
    ==
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    ?+    mark  (on-poke:def mark vase)
        %json
      =/  jon=json  !<(json vase)
      =/  jact=json  (got:hod jon 'action')
      ?>  ?=([$s *] jact)
      =/  act  p.jact
        ?+  act  (on-poke:def mark vase)
          %get-file
        =/  vact=json  (got:hod jon 'value')
        ?>  ?=([%s *] vact)
        =/  val  p.vact
        =/  =card  (handle-poke-request-file:cc *path) :: main thing to fix
        [[card]~ this]
        ==
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      =/  url  (parse-request-line url.request.inbound-request)
      :_  ?+  site.url  this
            [%'~spral' %get-file *]  this(fil (~(del by fil) (spat t.t.site.url)))
            ==
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
    ?.  ?=(%file-build -.wire)
      (on-arvo:def wire sign-arvo)
    =^  cards  state  (handle-build:cc sign-arvo wire)
    [cards this]

  ::
  ++  on-save  on-save:def
  ++  on-load
    |=  old=vase
    ^-  (quip card _this)
    =/  p  /[(scot %p our.bol)]/home/[(scot %da now.bol)]
    =/  rom  .^((list path) %ct p)
    =/  j  (paths-to-json:hod rom)
    `this(hon j)
  ++  on-leave  on-leave:def
  ++  on-peek
    |=  p=path
    ^-  (unit (unit cage))
    ?+  p  (on-peek:def p)
        [%x %hon ~]
        ``[%json !>(hon)]
        [%x %state ~]
        ``[%json !>((jsonify state))]
    ==
  ++  on-fail   on-fail:def
  --
::
::
|_  bol=bowl:gall

++  handle-poke-request-file
  |=  [p=path]
  ^-  card:agent:gall
  =/  rp=path  (flop p)
  =/  schema=schematic:ford
    [%cast [our.bol %home] %mime [%scry %c %x [our.bol %home] rp]]
  [%pass [%file-build p] %arvo %f %build %| schema]


++  tang-to-cord
  |=  =tang
  %-  crip
  %+  roll  tang
    |=  [item=tank acc=tape]
    %-  zing  ~[acc "/n" ~(ram re item)]

++  handle-build
  |=  [=sign-arvo =wire]
  ^-  (quip card state-zero)
  =,  enjs:format
  =/  wyr  (spat wire)
  ?>  ?=([%f %made *] sign-arvo)
  ?:  ?=(%incomplete -.result.sign-arvo)
      =/  tong=@t  (tang-to-cord +.result.sign-arvo)
      =/  jon=json
      %-  pairs  :~
        ['type' [%s 'file-incomplete']]
        ['path' [%s wyr]]
        ['value' [%s tong]]
      ==
      [[%give %fact ~[/primary] %json !>(jon)]~ state]
  =/  =build-result:ford  build-result.result.sign-arvo
  ?:  ?=(%error -.build-result)
      =/  eng  (tang-to-cord message.build-result)
      =/  jon
      %-  pairs  :~
        ['type' [%s 'file-error']]
        ['path' [%s wyr]]
        ['value' [%s eng]]
      ==
      [[%give %fact ~[/primary] %json !>(jon)]~ state]
  =/  =cage  (result-to-cage:ford build-result)
  ?.  ?=(%noun p.cage)
      =/  jon
      %-  pairs  :~
        ['type' [%s 'ANOMALY']]
        ['path' [%s wyr]]
      ==
      [[%give %fact ~[/primary] %json !>(jon)]~ state]
  =/  ret=mime  !<(mime q.cage)
  =.  fil  %+  ~(put by fil)  wire  ret
      =/  jon
      %-  pairs  :~
        ['type' [%s 'file-retrieved']]
        ['path' [%s wyr]]
      ==
      [[%give %fact ~[/primary] %json !>(jon)]~ state]

++  mime-response
  |=  =mime
  ^-  simple-payload:http
  [[200 ['content-type' (spat p.mime)]~] `q.mime]
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~spral' %css %index ~]  (css-response:gen style)
      [%'~spral' %js %tile ~]    (js-response:gen tile-js)
      [%'~spral' %js %index ~]   (js-response:gen script)
      [%'~spral' %get-file *]    (mime-response (~(got by fil) t.t.site.url))
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
