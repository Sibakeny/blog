$(".image-card-wrapper").on("click", function () {
  const urlInput = $(this).find(".image-url");
  urlInput.removeClass("d-none");
  urlInput.select();
  document.execCommand("Copy");
  urlInput.addClass("d-none");

  toastr.success("URLをコピーしました");
});

$(".image-card-wrapper").draggable({
  containment: ".draggable-area",
});

$("#trash").droppable({
  accept: ".image-card-wrapper",
  drop: function (e, ui) {
    console.log(this);
  },
});
