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
  // need to add click handlers
}

function renderLink(link) {
  var html = `
    <div class="col-md-4">
      <div class="panel panel-default" data-id=${ link.id }>
        <div class="panel-heading">
          <h3 class="panel-title" contenteditable=true>${ link.title }</h3>
        </div>
        <div class="panel-body">
          <h4 class="link-body text-center" contenteditable=true>
            ${ link.url }
            <a href="${ link.url }">
              <span class="glyphicon glyphicon-link" aria-hidden="true"></span>
            </a>
            <span class="glyphicon glyphicon-ok hidden" aria-hidden="true" data-id=${ link.id }></span>
          </h4>
        </div>
        <div class="panel-footer text-center" data-id=${ link.id }>
          <button type="button" class="btn btn-primary btn-delete">
            <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> Mark as Read
          </button>
          <button type="button" class="btn btn-danger btn-delete">
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

function newLink(title, url) {
  return { link: { title: title, url: url }}
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
