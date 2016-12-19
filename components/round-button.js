var roundButton, out$ = typeof exports != 'undefined' && exports || this;
out$.roundButton = roundButton = h(function(){
  return function(text, arg$){
    var bg, ref$;
    text == null && (text = '+');
    bg = (ref$ = arg$.bg) != null ? ref$ : 'blue';
    return h('button', h('span', text));
  };
});