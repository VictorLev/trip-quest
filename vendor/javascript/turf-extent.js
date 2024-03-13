import n from"turf-meta";var t={};var i=n.coordEach;t=function(n){var t=[Infinity,Infinity,-Infinity,-Infinity];i(n,(function(n){t[0]>n[0]&&(t[0]=n[0]);t[1]>n[1]&&(t[1]=n[1]);t[2]<n[0]&&(t[2]=n[0]);t[3]<n[1]&&(t[3]=n[1])}));return t};var r=t;export default r;

