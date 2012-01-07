(function(a){function f(a){return(new Date).getTime()-a.getTime()}function e(a){return b.inWords(f(a))}function d(c){c=a(c);if(!c.data("timeago")){c.data("timeago",{datetime:b.datetime(c)});var d=a.trim(c.text());if(d.length>0){c.attr("title",d)}}return c.data("timeago")}function c(){var b=d(this);if(!isNaN(b.datetime)){a(this).text(e(b.datetime))}return this}a.timeago=function(b){if(b instanceof Date){return e(b)}else if(typeof b==="string"){return e(a.timeago.parse(b))}else{return e(a.timeago.datetime(b))}};var b=a.timeago;a.extend(a.timeago,{settings:{refreshMillis:6e4,allowFuture:false,strings:{prefixAgo:null,prefixFromNow:null,suffixAgo:"ago",suffixFromNow:"from now",seconds:"less than a minute",minute:"about a minute",minutes:"%d minutes",hour:"about an hour",hours:"about %d hours",day:"a day",days:"%d days",month:"about a month",months:"%d months",year:"about a year",years:"%d years",numbers:[]}},inWords:function(b){function k(d,e){var f=a.isFunction(d)?d(e,b):d;var g=c.numbers&&c.numbers[e]||e;return f.replace(/%d/i,g)}var c=this.settings.strings;var d=c.prefixAgo;var e=c.suffixAgo;if(this.settings.allowFuture){if(b<0){d=c.prefixFromNow;e=c.suffixFromNow}}var f=Math.abs(b)/1e3;var g=f/60;var h=g/60;var i=h/24;var j=i/365;var l=f<45&&k(c.seconds,Math.round(f))||f<90&&k(c.minute,1)||g<45&&k(c.minutes,Math.round(g))||g<90&&k(c.hour,1)||h<24&&k(c.hours,Math.round(h))||h<48&&k(c.day,1)||i<30&&k(c.days,Math.floor(i))||i<60&&k(c.month,1)||i<365&&k(c.months,Math.floor(i/30))||j<2&&k(c.year,1)||k(c.years,Math.floor(j));return a.trim([d,l,e].join(" "))},parse:function(b){var c=a.trim(b);c=c.replace(/\.\d\d\d+/,"");c=c.replace(/-/,"/").replace(/-/,"/");c=c.replace(/T/," ").replace(/Z/," UTC");c=c.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2");return new Date(c)},datetime:function(c){var d=a(c).get(0).tagName.toLowerCase()==="time";var e=d?a(c).attr("datetime"):a(c).attr("title");return b.parse(e)}});a.fn.timeago=function(){var a=this;a.each(c);var d=b.settings;if(d.refreshMillis>0){setInterval(function(){a.each(c)},d.refreshMillis)}return a};document.createElement("abbr");document.createElement("time")})(jQuery)