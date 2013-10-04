$(document).ready(function () {
  // match the path with the trailing "/" removed
  // then select links with and without the "/" by reinserting it

  // short url match
  var pagepath = this.location.pathname;
  if(pagepath.charAt( pagepath.length-1 ) == "/") {
      pagepath = pagepath.slice(0, -1)
  }
  $('a[href="' + pagepath + '"]').parent().addClass('active');
  $('a[href="' + pagepath + '/"]').parent().addClass('active');

  // long url match
  var pageurl = document.URL;
  if(pageurl.charAt( pageurl.length-1 ) == "/") {
      pageurl = pageurl.slice(0, -1)
  }
  $('a[href="' + pageurl + '"]').parent().addClass('active');
  $('a[href="' + pageurl + '/"]').parent().addClass('active');
});
