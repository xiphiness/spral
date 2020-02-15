=,  able:jael
=,  ethereum-types


::  eth-watcher-diff
:: [%history =loglist]
:: ::  %log: newly added log
:: ::
:: [%log =event-log:rpc:ethereum]
:: ::  %disavow: forget logs
:: ::
:: ::    this is sent when a reorg happens that invalidates
:: ::    previously-sent logs
:: ::
:: [%disavow =id:block]

:: parse ABI
:: generate topic id -> event data types map
:: generate function name -> call data types map
::
::
:: rare %disavow case w/ ++release-logs only confirming blocks after 30 confirmations
:: (reorgs greater than 2 very rare)
::
::
:: taking $event-log from %eth-watcher-diff %log
:: i.topics.event-log is keccak hash
:: look up appropriate (list data:abi:eth) from parsed ABI
:: (decode-topics t.topcs.event-logc data-list-scheme)



|%
:: i is etyp per indexed topic type, d is etyp per unindexed event input
:: +$  event-type  [n=@t i=(list etyp:abi:ethereum) d=(list etyp:abi:ethereum)]
+$  event-type  [n=@t i=(list value-type) d=(list value-type)]
+$  events  (map @ux event-type)
+$  func-type  [sig=@ux i=(list etyp:abi:ethereum) o=etyp:abi:ethereum mut=? pay=?]
+$  funcs  (map @ta func-type)
+$  contract  [=events =funcs]


++  separate-indexed-inputs
  |=  pts=(list value-type)
  ^-  (pair (list value-type) (list value-type))
  %+  skid  pts
    |=  =value-type
    indexed.value-type

++  parse-event-types
  |=  entries=(list entry)
  ^-  events
  %-  molt
  |-  ^-  (list (pair @ux event-type))
  ?~  entries  ~
  =/  [dxt=(list value-type) nxt=(list value-type)]
    (separate-indexed-inputs inputs.i.entries)
    :-  :-  %+  get-hash  name.i.entries
        %+  turn  inputs.i.entries  |=(=value-type type.value-type)
        [name.i.entries dxt nxt]
    $(entries t.entries)

++  get-sig
  |=  [name=@t inputs=(list @t)]
  ^-  cord
  %-  crip
  :-  name  :-  '('  ?~  inputs  :-  ')'  ~
  :-  i.inputs
  |-  ^-  tape
  ?~  t.inputs  :-  ')'  ~
  :-  ','  :-  i.t.inputs  $(inputs t.inputs)

++  get-hash
  |=  [name=@t inputs=(list @t)]
  =/  sig  (get-sig name inputs)
  ^-  @ux
  (keccak-256:keccak:crypto (lent (trip sig)) sig)

  ::
  :: %address  %bool
  :: %int      %uint
  :: %real     %ureal
  :: [%bytes-n n=@ud]
  :: ::  dynamic
  :: [%array-n t=etyp n=@ud]
  :: [%array t=etyp]
  :: %bytes    %string
  ::

:: ++  prim-type
:: $%
::     %uint
::     %int
::     %boolean
::     %address
::     %string
:: ==



++  value-type
$:
  name=@t
  type=@t
  indexed=?
==

++  entry-type
$%
  %function
  %event
==

++  entry
$:
  name=@t
  type=entry-type
  inputs=(list value-type)
  outputs=(list value-type)
==

:: ++  cord-to-value-type
::   |=  jon=json
::   =,  dejs:format
::   =/  typ  (so jon)
::   ^-  prim-type
::   ?+  (crip (scag 3 (trip typ)))  ~&  [%unknown-abi-type typ]  !!
::     %uin  %uint
::     %int  %int
::     %boo  %boolean
::     %add  %address
::     %str  %string
::   ==
++  cord-to-entype
  |=  jon=json
  ^-  entry-type
  =,  dejs:format
  =/  typ  (so jon)
  ?+  (crip (scag 3 (trip typ)))  ~&  [%unknown-abi-type typ]  !!
    %fun  %function
    %eve  %event
  ==

++  to-value-type
  =,  dejs:format
  ^-  $-(json value-type)
  %-  ou
  :~
    :-  %name  (un so)
    :-  %type  (un so)
    :-  %indexed  %+  uf  %|  bo
  ==

++  parse-abi
  |=  jon=json
    ^-  (list entry)
    =,  dejs:format
    %.  jon  %-  ar
    %-  ou
    :~
      :-  %name  (un so)
      :-  %type  %-  un  cord-to-entype
      :-  %inputs  %-  un  %-  ar  to-value-type
      :-  %outputs  %+  uf  ~  %-  ar  to-value-type
    ==
++  separate-abi
  |=  entries=(list entry)
  ^-  (pair (list entry) (list entry))
  %+  skid  entries
  |=  =entry
    ^-  ?
    ?.  =(type.entry %function)
    ?.  =(type.entry %event)
    ~&  [%unexpected-entry-type type.entry]  !!
    %|
    %&
--
