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


How to reproduce?
------
Open IE (11,10) (or Edge) ideally with cleared browser cache. Open URL below or local host project `make dev`
and try to click on "Open", you'll see another button but clicking on this second button doesn't work.
Event not attached via Elm (onClick attribute) is fired (see console) but Elm msg is not properly handled.

For now it's not working only on first load of page (without cache) but we had this issue on our project (on production)
and this bug was caused every time (even if you reload page).

Could be checked here https://rawgit.com/janjelinek/elm-ie-issue/master/index.html


I hope this is enough to reproduce this bug on every device with Internet Explorer or Edge browser.
