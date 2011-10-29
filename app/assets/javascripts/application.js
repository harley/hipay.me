// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require_self
//= require jquery
//= require jquery_ujs
//= require bootstrap/bootstrap-modal.js
//= require bootstrap/bootstrap-alerts.js
//= require bootstrap/bootstrap-twipsy.js
//= require bootstrap/bootstrap-dropdown.js
//= require bootstrap/bootstrap-popover.js
//= require bootstrap/bootstrap-scrollspy.js
//= require bootstrap/bootstrap-tabs.js
//= require home
//= require invoices
//= require payments
//= require stripe_setup
//= require payslips

// make console.log work
(function(b){function c(){}for(var d="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console=window.console||{});
