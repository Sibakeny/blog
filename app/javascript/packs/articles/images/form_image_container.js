$(".image-card-wrapper").on("click", function () {
  const urlInput = $(this).find(".image-url");
  urlInput.removeClass("d-none");
  urlInput.select();
  document.execCommand("Copy");
  urlInput.addClass("d-none");

  toastr.success("URLをコピーしました");
});

var dragItem = document.getElementsByClassName("image-card-wrapper");
var trash = document.getElementById("trash");

for (let i = 0; i < dragItem.length; i++) {
  dragItem[i].addEventListener(
    "dragstart",
    function (e) {
      console.log("start");
      e.dataTransfer.setData("text/plain", $(this).attr("id"));
    },
    false
  );
}

trash.addEventListener("drop", function (e) {
  var itemId = e.dataTransfer.getData("text/plain");
  var itemIdTxt = "#" + itemId;
  var articleId = $(itemIdTxt).data("article-id");
  var imageId = $(itemIdTxt).data("id");
  $.ajax({
    url: `/articles/${articleId}/images/${imageId}`,
    type: "delete",
    beforeSend: function (xhr) {
      xhr.setRequestHeader(
        "X-CSRF-Token",
        $('meta[name="csrf-token"]').attr("content")
      );
    },
  }).then(() => {
    $(itemIdTxt).remove();
    toastr.error("画像を削除しました。");
  });
});

trash.addEventListener(
  "dragover",
  function (evt) {
    evt.preventDefault();
  },
  false
);

trash.addEventListener(
  "dragenter",
  function (evt) {
    evt.preventDefault();
  },
  false
);
