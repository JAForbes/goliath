defaults =
  button:
    style: ".bg-blue.bw0.outline-0"
    size: ".w3.h3.f1"
    shape: ".br-100"
    behaviour: ".grow"

  content:
    style: ".white"
    size: ""
    shape: ""
    behaviour: ""

view = (h) -> ({ button={}, content={} }={}) ->
  a = defaults.button with button
  b = defaults.content with content

  (text, onclick, attrs) ->

    h 'button' + a<[size style shape behaviour]> * ""
      , { onclick } <<< attrs
      , h 'span' + b<[size style shape behaviour]> * "", text

export { view, defaults }
