import e from"@babel/runtime/helpers/esm/objectSpread2";
/**
 * Adapted from React: https://github.com/facebook/react/blob/master/packages/shared/formatProdErrorMessage.js
 *
 * Do not require this module directly! Use normal throw error calls. These messages will be replaced with error codes
 * during build.
 * @param {number} code
 */function formatProdErrorMessage(e){return"Minified Redux error #"+e+"; visit https://redux.js.org/Errors?code="+e+" for the full message or use the non-minified dev environment for full errors. "}var r=function(){return"function"===typeof Symbol&&Symbol.observable||"@@observable"}();var t=function randomString(){return Math.random().toString(36).substring(7).split("").join(".")};var n={INIT:"@@redux/INIT"+t(),REPLACE:"@@redux/REPLACE"+t(),PROBE_UNKNOWN_ACTION:function PROBE_UNKNOWN_ACTION(){return"@@redux/PROBE_UNKNOWN_ACTION"+t()}};
/**
 * @param {any} obj The object to inspect.
 * @returns {boolean} True if the argument appears to be a plain object.
 */function isPlainObject(e){if("object"!==typeof e||null===e)return false;var r=e;while(null!==Object.getPrototypeOf(r))r=Object.getPrototypeOf(r);return Object.getPrototypeOf(e)===r}function miniKindOf(e){if(void 0===e)return"undefined";if(null===e)return"null";var r=typeof e;switch(r){case"boolean":case"string":case"number":case"symbol":case"function":return r}if(Array.isArray(e))return"array";if(isDate(e))return"date";if(isError(e))return"error";var t=ctorName(e);switch(t){case"Symbol":case"Promise":case"WeakMap":case"WeakSet":case"Map":case"Set":return t}return r.slice(8,-1).toLowerCase().replace(/\s/g,"")}function ctorName(e){return"function"===typeof e.constructor?e.constructor.name:null}function isError(e){return e instanceof Error||"string"===typeof e.message&&e.constructor&&"number"===typeof e.constructor.stackTraceLimit}function isDate(e){return e instanceof Date||"function"===typeof e.toDateString&&"function"===typeof e.getDate&&"function"===typeof e.setDate}function kindOf(e){var r=typeof e;"production"!==process.env.NODE_ENV&&(r=miniKindOf(e));return r}
/**
 * @deprecated
 *
 * **We recommend using the `configureStore` method
 * of the `@reduxjs/toolkit` package**, which replaces `createStore`.
 *
 * Redux Toolkit is our recommended approach for writing Redux logic today,
 * including store setup, reducers, data fetching, and more.
 *
 * **For more details, please read this Redux docs page:**
 * **https://redux.js.org/introduction/why-rtk-is-redux-today**
 *
 * `configureStore` from Redux Toolkit is an improved version of `createStore` that
 * simplifies setup and helps avoid common bugs.
 *
 * You should not be using the `redux` core package by itself today, except for learning purposes.
 * The `createStore` method from the core `redux` package will not be removed, but we encourage
 * all users to migrate to using Redux Toolkit for all Redux code.
 *
 * If you want to use `createStore` without this visual deprecation warning, use
 * the `legacy_createStore` import instead:
 *
 * `import { legacy_createStore as createStore} from 'redux'`
 *
 */function createStore(e,t,o){var i;if("function"===typeof t&&"function"===typeof o||"function"===typeof o&&"function"===typeof arguments[3])throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(0):"It looks like you are passing several store enhancers to createStore(). This is not supported. Instead, compose them together to a single function. See https://redux.js.org/tutorials/fundamentals/part-4-store#creating-a-store-with-enhancers for an example.");if("function"===typeof t&&"undefined"===typeof o){o=t;t=void 0}if("undefined"!==typeof o){if("function"!==typeof o)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(1):"Expected the enhancer to be a function. Instead, received: '"+kindOf(o)+"'");return o(createStore)(e,t)}if("function"!==typeof e)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(2):"Expected the root reducer to be a function. Instead, received: '"+kindOf(e)+"'");var a=e;var s=t;var c=[];var u=c;var d=false;function ensureCanMutateNextListeners(){u===c&&(u=c.slice())}
/**
   * Reads the state tree managed by the store.
   *
   * @returns {any} The current state tree of your application.
   */function getState(){if(d)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(3):"You may not call store.getState() while the reducer is executing. The reducer has already received the state as an argument. Pass it down from the top reducer instead of reading it from the store.");return s}
/**
   * Adds a change listener. It will be called any time an action is dispatched,
   * and some part of the state tree may potentially have changed. You may then
   * call `getState()` to read the current state tree inside the callback.
   *
   * You may call `dispatch()` from a change listener, with the following
   * caveats:
   *
   * 1. The subscriptions are snapshotted just before every `dispatch()` call.
   * If you subscribe or unsubscribe while the listeners are being invoked, this
   * will not have any effect on the `dispatch()` that is currently in progress.
   * However, the next `dispatch()` call, whether nested or not, will use a more
   * recent snapshot of the subscription list.
   *
   * 2. The listener should not expect to see all state changes, as the state
   * might have been updated multiple times during a nested `dispatch()` before
   * the listener is called. It is, however, guaranteed that all subscribers
   * registered before the `dispatch()` started will be called with the latest
   * state by the time it exits.
   *
   * @param {Function} listener A callback to be invoked on every dispatch.
   * @returns {Function} A function to remove this change listener.
   */function subscribe(e){if("function"!==typeof e)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(4):"Expected the listener to be a function. Instead, received: '"+kindOf(e)+"'");if(d)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(5):"You may not call store.subscribe() while the reducer is executing. If you would like to be notified after the store has been updated, subscribe from a component and invoke store.getState() in the callback to access the latest state. See https://redux.js.org/api/store#subscribelistener for more details.");var r=true;ensureCanMutateNextListeners();u.push(e);return function unsubscribe(){if(r){if(d)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(6):"You may not unsubscribe from a store listener while the reducer is executing. See https://redux.js.org/api/store#subscribelistener for more details.");r=false;ensureCanMutateNextListeners();var t=u.indexOf(e);u.splice(t,1);c=null}}}
/**
   * Dispatches an action. It is the only way to trigger a state change.
   *
   * The `reducer` function, used to create the store, will be called with the
   * current state tree and the given `action`. Its return value will
   * be considered the **next** state of the tree, and the change listeners
   * will be notified.
   *
   * The base implementation only supports plain object actions. If you want to
   * dispatch a Promise, an Observable, a thunk, or something else, you need to
   * wrap your store creating function into the corresponding middleware. For
   * example, see the documentation for the `redux-thunk` package. Even the
   * middleware will eventually dispatch plain object actions using this method.
   *
   * @param {Object} action A plain object representing “what changed”. It is
   * a good idea to keep actions serializable so you can record and replay user
   * sessions, or use the time travelling `redux-devtools`. An action must have
   * a `type` property which may not be `undefined`. It is a good idea to use
   * string constants for action types.
   *
   * @returns {Object} For convenience, the same action object you dispatched.
   *
   * Note that, if you use a custom middleware, it may wrap `dispatch()` to
   * return something else (for example, a Promise you can await).
   */function dispatch(e){if(!isPlainObject(e))throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(7):"Actions must be plain objects. Instead, the actual type was: '"+kindOf(e)+"'. You may need to add middleware to your store setup to handle dispatching other values, such as 'redux-thunk' to handle dispatching functions. See https://redux.js.org/tutorials/fundamentals/part-4-store#middleware and https://redux.js.org/tutorials/fundamentals/part-6-async-logic#using-the-redux-thunk-middleware for examples.");if("undefined"===typeof e.type)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(8):'Actions may not have an undefined "type" property. You may have misspelled an action type string constant.');if(d)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(9):"Reducers may not dispatch actions.");try{d=true;s=a(s,e)}finally{d=false}var r=c=u;for(var t=0;t<r.length;t++){var n=r[t];n()}return e}
/**
   * Replaces the reducer currently used by the store to calculate the state.
   *
   * You might need this if your app implements code splitting and you want to
   * load some of the reducers dynamically. You might also need this if you
   * implement a hot reloading mechanism for Redux.
   *
   * @param {Function} nextReducer The reducer for the store to use instead.
   * @returns {void}
   */function replaceReducer(e){if("function"!==typeof e)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(10):"Expected the nextReducer to be a function. Instead, received: '"+kindOf(e));a=e;dispatch({type:n.REPLACE})}
/**
   * Interoperability point for observable/reactive libraries.
   * @returns {observable} A minimal observable of state changes.
   * For more information, see the observable proposal:
   * https://github.com/tc39/proposal-observable
   */function observable(){var e;var t=subscribe;return e={
/**
       * The minimal observable subscription method.
       * @param {Object} observer Any object that can be used as an observer.
       * The observer object should have a `next` method.
       * @returns {subscription} An object with an `unsubscribe` method that can
       * be used to unsubscribe the observable from the store, and prevent further
       * emission of values from the observable.
       */
subscribe:function subscribe(e){if("object"!==typeof e||null===e)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(11):"Expected the observer to be an object. Instead, received: '"+kindOf(e)+"'");function observeState(){e.next&&e.next(getState())}observeState();var r=t(observeState);return{unsubscribe:r}}},e[r]=function(){return this},e}dispatch({type:n.INIT});return i={dispatch:dispatch,subscribe:subscribe,getState:getState,replaceReducer:replaceReducer},i[r]=observable,i
/**
 * Creates a Redux store that holds the state tree.
 *
 * **We recommend using `configureStore` from the
 * `@reduxjs/toolkit` package**, which replaces `createStore`:
 * **https://redux.js.org/introduction/why-rtk-is-redux-today**
 *
 * The only way to change the data in the store is to call `dispatch()` on it.
 *
 * There should only be a single store in your app. To specify how different
 * parts of the state tree respond to actions, you may combine several reducers
 * into a single reducer function by using `combineReducers`.
 *
 * @param {Function} reducer A function that returns the next state tree, given
 * the current state tree and the action to handle.
 *
 * @param {any} [preloadedState] The initial state. You may optionally specify it
 * to hydrate the state from the server in universal apps, or to restore a
 * previously serialized user session.
 * If you use `combineReducers` to produce the root reducer function, this must be
 * an object with the same shape as `combineReducers` keys.
 *
 * @param {Function} [enhancer] The store enhancer. You may optionally specify it
 * to enhance the store with third-party capabilities such as middleware,
 * time travel, persistence, etc. The only store enhancer that ships with Redux
 * is `applyMiddleware()`.
 *
 * @returns {Store} A Redux store that lets you read the state, dispatch actions
 * and subscribe to changes.
 */}var o=createStore;
/**
 * Prints a warning in the console if it exists.
 *
 * @param {String} message The warning message.
 * @returns {void}
 */function warning(e){"undefined"!==typeof console&&"function"===typeof console.error&&console.error(e);try{throw new Error(e)}catch(e){}}function getUnexpectedStateShapeWarningMessage(e,r,t,o){var i=Object.keys(r);var a=t&&t.type===n.INIT?"preloadedState argument passed to createStore":"previous state received by the reducer";if(0===i.length)return"Store does not have a valid reducer. Make sure the argument passed to combineReducers is an object whose values are reducers.";if(!isPlainObject(e))return"The "+a+' has unexpected type of "'+kindOf(e)+'". Expected argument to be an object with the following keys: "'+i.join('", "')+'"';var s=Object.keys(e).filter((function(e){return!r.hasOwnProperty(e)&&!o[e]}));s.forEach((function(e){o[e]=true}));return t&&t.type===n.REPLACE?void 0:s.length>0?"Unexpected "+(s.length>1?"keys":"key")+' "'+s.join('", "')+'" found in '+a+'. Expected to find one of the known reducer keys instead: "'+i.join('", "')+'". Unexpected keys will be ignored.':void 0}function assertReducerShape(e){Object.keys(e).forEach((function(r){var t=e[r];var o=t(void 0,{type:n.INIT});if("undefined"===typeof o)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(12):'The slice reducer for key "'+r+"\" returned undefined during initialization. If the state passed to the reducer is undefined, you must explicitly return the initial state. The initial state may not be undefined. If you don't want to set a value for this reducer, you can use null instead of undefined.");if("undefined"===typeof t(void 0,{type:n.PROBE_UNKNOWN_ACTION()}))throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(13):'The slice reducer for key "'+r+"\" returned undefined when probed with a random type. Don't try to handle '"+n.INIT+'\' or other actions in "redux/*" namespace. They are considered private. Instead, you must return the current state for any unknown actions, unless it is undefined, in which case you must return the initial state, regardless of the action type. The initial state may not be undefined, but can be null.')}))}
/**
 * Turns an object whose values are different reducer functions, into a single
 * reducer function. It will call every child reducer, and gather their results
 * into a single state object, whose keys correspond to the keys of the passed
 * reducer functions.
 *
 * @param {Object} reducers An object whose values correspond to different
 * reducer functions that need to be combined into one. One handy way to obtain
 * it is to use ES6 `import * as reducers` syntax. The reducers may never return
 * undefined for any action. Instead, they should return their initial state
 * if the state passed to them was undefined, and the current state for any
 * unrecognized action.
 *
 * @returns {Function} A reducer function that invokes every reducer inside the
 * passed object, and builds a state object with the same shape.
 */function combineReducers(e){var r=Object.keys(e);var t={};for(var n=0;n<r.length;n++){var o=r[n];"production"!==process.env.NODE_ENV&&"undefined"===typeof e[o]&&warning('No reducer provided for key "'+o+'"');"function"===typeof e[o]&&(t[o]=e[o])}var i=Object.keys(t);var a;"production"!==process.env.NODE_ENV&&(a={});var s;try{assertReducerShape(t)}catch(e){s=e}return function combination(e,r){void 0===e&&(e={});if(s)throw s;if("production"!==process.env.NODE_ENV){var n=getUnexpectedStateShapeWarningMessage(e,t,r,a);n&&warning(n)}var o=false;var c={};for(var u=0;u<i.length;u++){var d=i[u];var f=t[d];var p=e[d];var l=f(p,r);if("undefined"===typeof l){var h=r&&r.type;throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(14):"When called with an action of type "+(h?'"'+String(h)+'"':"(unknown type)")+', the slice reducer for key "'+d+'" returned undefined. To ignore an action, you must explicitly return the previous state. If you want this reducer to hold no value, you can return null instead of undefined.')}c[d]=l;o=o||l!==p}o=o||i.length!==Object.keys(e).length;return o?c:e}}function bindActionCreator(e,r){return function(){return r(e.apply(this,arguments))}}
/**
 * Turns an object whose values are action creators, into an object with the
 * same keys, but with every function wrapped into a `dispatch` call so they
 * may be invoked directly. This is just a convenience method, as you can call
 * `store.dispatch(MyActionCreators.doSomething())` yourself just fine.
 *
 * For convenience, you can also pass an action creator as the first argument,
 * and get a dispatch wrapped function in return.
 *
 * @param {Function|Object} actionCreators An object whose values are action
 * creator functions. One handy way to obtain it is to use ES6 `import * as`
 * syntax. You may also pass a single function.
 *
 * @param {Function} dispatch The `dispatch` function available on your Redux
 * store.
 *
 * @returns {Function|Object} The object mimicking the original object, but with
 * every action creator wrapped into the `dispatch` call. If you passed a
 * function as `actionCreators`, the return value will also be a single
 * function.
 */function bindActionCreators(e,r){if("function"===typeof e)return bindActionCreator(e,r);if("object"!==typeof e||null===e)throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(16):"bindActionCreators expected an object or a function, but instead received: '"+kindOf(e)+'\'. Did you write "import ActionCreators from" instead of "import * as ActionCreators from"?');var t={};for(var n in e){var o=e[n];"function"===typeof o&&(t[n]=bindActionCreator(o,r))}return t}
/**
 * Composes single-argument functions from right to left. The rightmost
 * function can take multiple arguments as it provides the signature for
 * the resulting composite function.
 *
 * @param {...Function} funcs The functions to compose.
 * @returns {Function} A function obtained by composing the argument functions
 * from right to left. For example, compose(f, g, h) is identical to doing
 * (...args) => f(g(h(...args))).
 */function compose(){for(var e=arguments.length,r=new Array(e),t=0;t<e;t++)r[t]=arguments[t];return 0===r.length?function(e){return e}:1===r.length?r[0]:r.reduce((function(e,r){return function(){return e(r.apply(void 0,arguments))}}))}
/**
 * Creates a store enhancer that applies middleware to the dispatch method
 * of the Redux store. This is handy for a variety of tasks, such as expressing
 * asynchronous actions in a concise manner, or logging every action payload.
 *
 * See `redux-thunk` package as an example of the Redux middleware.
 *
 * Because middleware is potentially asynchronous, this should be the first
 * store enhancer in the composition chain.
 *
 * Note that each middleware will be given the `dispatch` and `getState` functions
 * as named arguments.
 *
 * @param {...Function} middlewares The middleware chain to be applied.
 * @returns {Function} A store enhancer applying the middleware.
 */function applyMiddleware(){for(var r=arguments.length,t=new Array(r),n=0;n<r;n++)t[n]=arguments[n];return function(r){return function(){var n=r.apply(void 0,arguments);var o=function dispatch(){throw new Error("production"===process.env.NODE_ENV?formatProdErrorMessage(15):"Dispatching while constructing your middleware is not allowed. Other middleware would not be applied to this dispatch.")};var i={getState:n.getState,dispatch:function dispatch(){return o.apply(void 0,arguments)}};var a=t.map((function(e){return e(i)}));o=compose.apply(void 0,a)(n.dispatch);return e(e({},n),{},{dispatch:o})}}}export{n as __DO_NOT_USE__ActionTypes,applyMiddleware,bindActionCreators,combineReducers,compose,createStore,o as legacy_createStore};

