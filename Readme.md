# elm-ie-issue
Just code to help replicate issue with Internet explorer

Trying to create minimal app with specific issue on Internet Explorer 11/10 and Edge.
It happens when some submodule returns `Html.text ""` and it's mapped to specific Msg in parent module.
When this submodule state is changed and `Html.text ""` is replaced by some other stuff with Events, those Events are not propagated
to parent module. In source code of Elm is missing info about mapped Msg.

Dumped code via debugger from real live code:

Chrome vs IE (simple dump of objects - patches from compiled Elm code)

```
20 397 p-redraw #text undefined undefined undefined NaN|undefined|tagger: function (a) {
			return {ctor: 'UpsellMsg', _0: a};
		}| undefined|parent|undefined||tagger: function enqueue(msg)
			{
				_elm_lang$core$Native_Scheduler.rawSend(mainProcess, msg);
			}| undefined||parent: undefined|
```

```
20 397 p-redraw #text undefined undefined undefined undefined
```


Once this will be ready and tested you can check it yourself this https://rawgit.com/janjelinek/elm-ie-issue/master/index.html

 Currently this code not causing ERROR, still in progress to get right combination of elements, events and so on....
 ---------
