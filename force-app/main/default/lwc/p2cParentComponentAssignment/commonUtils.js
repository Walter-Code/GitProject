const test = () => {
    window.addEventListener("load",function(){const e=document.getElementById("channext-banners");if(e&&!e.getElementsByTagName("iframe")[0]){var t=[],n=(["a","i","b","f","q","r","s","a","h","m","o","e"].reduce(function(e,t,n,i){return n%2==0&&e.push(i.slice(n+1,n+2)[0]),e},t),t.join("")),i=document.createElement(n),a=e.dataset.source,d=e.dataset.width||"100%";i.width=d,i.style.border="none",i.src=a;var c=Math.ceil(e.getBoundingClientRect().width/3);window.matchMedia("(max-width: 480px)").matches&&(c=Math.ceil(.75*e.getBoundingClientRect().width)),i.height=c,e.appendChild(i)}});
} 
export { test };