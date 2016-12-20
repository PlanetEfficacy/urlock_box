var newLinkTitle, newLinkUrl
var api = "api/v1/links"

$(document).ready(function() {
  newLinkTitle = $('#create-link-title');
  newLinkUrl = $('#create-link-url');
  linkList = $("#link-list");
  $('#create-link-button').on('click', createLink);
  getLinks();
})

function getLinks() {
  $.getJSON(api)
  .then(renderLinks)
}

function renderLinks(data) {
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
          <button type="button" class="btn btn-primary btn-read">
            <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> Mark as Read
          </button>
          <button type="button" class="btn btn-danger btn-unread">
            <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span> Mark as Unread
          </button>
        </div>
      </div>
    </div>
  `;
  linkList.prepend(html)
  read_status = $( "body" ).find('span[data-id=' + link.id + ']')
  if(link.status === 1) {
    console.log(read_status)
    read_status.removeClass('hidden')
  }
}

function newLink(title, url, status) {
  return { link: { title: title, url: url, status: status }}
}

function createLink() {
  event.preventDefault();
  // console.log(newLink(newLinkTitle.val(), newLinkUrl.val()))
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
  var panel = $(this).closest(".panel"),
      id = panel.data('id'),
      title = panel.find(".panel-title").text(),
      url = panel.find(".link-url").text().trim(),
      status = $(this).hasClass('btn-read') ? 1 : 0,
      link = newLink(title, url, status);
  $.ajax({
    url: `/${api}/${id}`,
    method: 'put',
    data: link,
    type: 'json'
  }).then(renderUpdate)

  function renderUpdate(data) {
    console.log(data.status)
    if(data.status === 1) {
      $( "body" ).find('span[data-id=' + data.id + ']').removeClass('hidden')
    } else {
      $( "body" ).find('span[data-id=' + data.id + ']').addClass('hidden')
    }
  }
}
