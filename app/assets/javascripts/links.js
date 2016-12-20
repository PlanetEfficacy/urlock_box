var newLinkTitle, newLinkUrl;
var api = "api/v1/links";
var allLinks = "";

$(document).ready(function() {
  newLinkTitle = $('#create-link-title');
  newLinkUrl = $('#create-link-url');
  linkList = $("#link-list");
  $('#filter').on('change', filterLinks)
  $('#create-link-button').on('click', createLink);
  $('#search').on('keyup', search)
  getLinks();
})

function getLinks() {
  $.getJSON(api)
  .then(renderLinks)
}

function renderLinks(data) {
  allLinks = data;
  data.forEach(renderLink);
  addClickHandlers()
}

function renderLink(link) {
  var html = `
    <div class="col-md-4">
      <div class="panel panel-default" data-id=${ link.id }>
        <div class="panel-heading">
          <h3 class="panel-title" contenteditable=true>${ link.title }</h3>
        </div>
        <div class="panel-body">
          <h4 class="link-url text-center" contenteditable=true>
            ${ link.url }
            <a href="${ link.url }">
              <span class="glyphicon glyphicon-link" aria-hidden="true"></span>
            </a>
            <span class="glyphicon glyphicon-ok hidden" aria-hidden="true" data-id=${ link.id }></span>
          </h4>
        </div>
        <div class="panel-footer text-center" data-id=${ link.id }>
          <button type="button" class="btn btn-primary btn-read" data-id=${ link.id }>
            <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> Mark as Read
          </button>
          <button type="button" class="btn btn-danger btn-unread" data-id=${ link.id }>
            <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> Mark as Unread
          </button>
        </div>
      </div>
    </div>`;
  linkList.prepend(html);
  var id = link.id
  var read_status = $( "body" ).find('span[data-id=' + id + ']');
  var read = $('.btn-read[data-id=' + id + ']');
  var unread = $('.btn-unread[data-id=' + id + ']');
  if(link.status === 1) {
    read_status.removeClass('hidden')
    read.addClass('hidden')
    unread.removeClass('hidden')
  } else {
    read_status.addClass('hidden')
    read.removeClass('hidden')
    unread.addClass('hidden')
  }
}

function newLink(title, url, status) {
  return { link: { title: title, url: url, status: status }}
}

function createLink() {
  event.preventDefault();
  $.post(api, newLink(newLinkTitle.val(), newLinkUrl.val()))
   .then(renderLink)
   .then(clearForm)
}

function clearForm() {
  newLinkTitle.val("")
  newLinkUrl.val("")
}


function addClickHandlers() {
  $(".btn-read").on('click', editLink);
  $(".btn-unread").on('click', editLink);
  $(".panel-title").on('blur', editLink);
  $(".link-url").on('blur', editLink);
}

function editLink() {
  var status = $(this).hasClass('btn-read') ? 1 : 0;
  $(this).addClass('hidden');
  var panel = $(this).closest(".panel"),
      id = panel.data('id'),
      title = panel.find(".panel-title").text(),
      url = panel.find(".link-url").text().trim(),
      link = newLink(title, url, status);
  if(status === 1) {
    $(this).find('btn-unread').removeClass('hidden');
  } else {
    $(this).find('btn-read').removeClass('hidden');
  }

  $.post('https://shrouded-meadow-76570.herokuapp.com/api/v1/reads',
          { link: { title: title, url: url }})

  $.ajax({
    url: `/${api}/${id}`,
    method: 'put',
    data: link,
    type: 'json'
  }).then(renderUpdate)
}

function renderUpdate(data) {
  if(data.status === 1) {
    $('span[data-id=' + data.id + ']').removeClass('hidden')
    $('.btn-read[data-id=' + data.id + ']').addClass('hidden')
    $('.btn-unread[data-id=' + data.id + ']').removeClass('hidden')
  } else {
    $('span[data-id=' + data.id + ']').addClass('hidden')
    $('.btn-unread[data-id=' + data.id + ']').addClass('hidden')
    $('.btn-read[data-id=' + data.id + ']').removeClass('hidden')
  }
}

function filterLinks(){
  linkList.html("")
  if($(this).val() === "All"){
    getLinks()
  } else if ($(this).val() === "Read"){
    getReadLinks()
  } else {
    getUnreadLinks()
  }
}

function getReadLinks() {
  $.getJSON('api/v1/read')
  .then(renderLinks)
}

function getUnreadLinks() {
  $.getJSON('api/v1/unread')
  .then(renderLinks)
}

function search() {
  $.getJSON(api).then(function(data){
    var searchString = $("#search").val().toLowerCase()
    if (searchString.length > 0) {
      data = allLinks.filter(function(link){
        return link.title.toLowerCase().includes(searchString) || link.url.includes(searchString)
      });
    }
    linkList.html("")
    renderLinks(data);
  })
}
