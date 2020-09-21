$('body').on('hidden.bs.modal', '.modal', function() {
  $(this).closest('.modal-container').remove();
})