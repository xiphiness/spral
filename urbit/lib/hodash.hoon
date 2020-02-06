=,  format
|%
  :: ++  kora   ^-  json  $~  ~  _(pairs:enjs:format ~[[%fil ~] [%dir kora]]

  :: ++  jankh  `/`$~(~ _^-(json (pairs:enjs:format ~[[%fil ~] [%dir jankh]])))
  ::
  :: ++  map-to-ankh
  ::   |=  hat/(map path (pair lobe cage))
  ::   ^-  ankh
  ::   %+  roll  ~(tap by hat)
  ::   |=  {{pat/path lob/lobe zar/cage} ank/ankh}
  ::   ^-  ankh
  ::   ?~  pat
  ::     ank(fil [~ lob zar])
  ::   =+  nak=(~(get by dir.ank) i.pat)
  ::   %=  ank
  ::     dir  %+  ~(put by dir.ank)  i.pat
  ::          $(pat t.pat, ank (fall nak *ankh))
  ::   ==

  :: =/   jir=(map @t json)
  ::   =/  ujir=(unit json)  (get jank 'dir')
  ::     ?~  ujir  *(map @t json)
  ::     p.ujir
  ::


  :: an ode to map-to-ankh
  ++  paths-to-json
    |=  hat/(list path)
    ^-  json
    %+  roll  hat
    |=  [pat=path jank=json]
    ^-  json
    =.  jank  ?~  jank  [%o *(map @t json)]  jank
    ?~  pat
      ?~  jank
        ~
      jank
    ?~  jank  ~
    ?+  -.jank  !!
      %o
      =/  junk=(map @t json)  =/  ujunk=(unit json)  (~(get by p.jank) 'dir')
        ?~  ujunk  *(map @t json)
          ?+  -.u.ujunk  !!
            %o  p.u.ujunk
          ==
      =/  jir=(map @t json)  =/  ujir=(unit json)  (~(get by junk) i.pat)
        ?~  ujir  *(map @t json)
          ?+  -.u.ujir  !!
            %o  p.u.ujir
          ==

      :-  %o  %+  ~(put by p.jank)  'dir'
      :-  %o  %+  ~(put by junk)  i.pat
      =/  jink=json
        :-  %o  %-  ~(put by jir)
        ?~  t.pat  :-  'fil'  :-  %b  %&
        =/  jor=(map @t json)  =/  ujor=(unit json)  (~(get by jir) 'dir')
          ?~  ujor  *(map @t json)
            ?+  -.u.ujor  !!
              %o  p.u.ujor
            ==
        :-  'dir'  :-  %o  jor
      $(pat t.pat, jank jink)
    ==


  ++  put
    |=  [key=@tas jon=json wut=json]
    ^-  json
    ?~  jon  !!
    ?+  -.jon  !!
      %o  :-  %o  (~(put by p.jon) key wut)
    ==

  ++  relp
    |=  [p=path q=path]
    ^-  path
    |-
    ?~  p  ~
    ?:  =(-:p -:q)
      $(p +:p, q +:q)
    (flop p)

  ++  get
    |=  [j=json k=@t]
    ^-  (unit json)
    ?~  j  !!
    ?+  -.j  !!
      %o  (~(get by p.j) k)
    ==
  ++  got
    |=  [j=json k=@t]
    ^-  json
    ?~  j  !!
    ?+  -.j  !!
      %o  %-  need  (~(get by p.j) k)
    ==
  ++  key
    |=  [j=json]
    ?~  j  !!
    ?+  -.j  !!
      %o  ~(key by p.j)
    ==
  ++  unwrap-vurs
    |=  [j=json]
    ?~  j  !!
    ?+  -.j  !!
      %a  p.j
    ==
  ++  unwrap-obj
    |=  [j=json]
    ?~  j  !!
    ?+  -.j  !!
      %o  p.j
    ==
  ++  get-by-path
    |=  [j=json p=path]
    =/  r=(unit json)  (some j)
    |-  ^-  (unit json)
    ?~  p  r
    ?~  r  ~
    $(p t.p, r (get u.r i.p))
  ++  got-by-path
    |=  [j=json p=path]
    |-  ^-  json
    ?~  p  j
    $(p t.p, j (got j i.p))

--
