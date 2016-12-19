Goliath
=======

> This is just a brain dump, read at your own peril.

There's a problem, we're all writing the same component again and again in every framework.

And these components are often either highly configurable (and hard to setup), or built for a specific use case 
(and less useful for most other cases).

So this is an experiment where we bet big on css class composition as the solution for configuration.

I'm also sticking to stateless functions becase they work everywhere.  State is always injected via get/set functions
that are configurable in your given context.  These get/set functions are passed as arguments to the view
and could be simply a front for a POJO, mutating the URL, dispatching Redux actions, pushing data into an Rx Subject, you name it.

Functions work everywhere, css classes work everywhere.


And if we divide styles into separate categories (behaviour, size, shape, colour, etc), 
it might make them easier to customize without overwriting styles we want to retain.

```ls
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
```

Using livescript for no particular reason:
https://github.com/JAForbes/goliath/blob/master/components/round-button/round-button.ls
proof of concept demo: http://james-forbes.com/goliath/components/round-button/

So its theoretically easy to replace classes for e.g. size without overwriting styles for behaviour, colour or shape
And you can still just pass in a normal attrs hash to do whatever styles you want manually using JS in CSS techniques.

I want a way for us to write components that work in many frameworks, that have good defaults but are easy to configure.  
I'm betting tachyons plugs a big part of the hole, small composable instructions that can either be extended, 
augmented or replaced entirely.  I'm also assuming JS is in play.

> Components that don't require JS are awesome though!

So my idea is, divide styles into layers that make it convenient to replace say, hover behaviour without touching colour/font/shape/size.
You can completely ignore that layer and you just get a nice component with a default theme, you can also side step tachyons all together 
and just use your own classnames, even if they're in a oocss style.  

I think we can build theming layers on top of this system too!

So you might have a module that defines a "theme" which is just a hash of css classes 
keyed by category (behaviors,sizes,styles,resets,shape,etc) that many components share.
And I'm thinking you could optionally do all this config manually in your given app, or have a build step that injects the theme, 
the hyperscript library, and an aggregate of components you want to use so the setup doesn't need to happen 
for every component, you'd just get a nice bundle preconfigured for say material design + mithril, 
or bootstrap style + snabbdom, but the actual business logic and structure for the component would be framework portable.

"Hyperscript" becomes the rosetta stone so to speak and we paper over inconsistencies.

What sort of inconsistencies?

E.g. http://james-forbes.com/goliath/components/tab-pane/

I'm exposing two functions `getTabId` and `setTabId`, in the context of mithril, that could just be a prop, 
in redux, that could be an action dispatcher, it could also be writing reading from the URL, 
the business logic doesn't know about mithril / react/ whatever, its all just pure stateless functions, 
because that is powerful/portable.