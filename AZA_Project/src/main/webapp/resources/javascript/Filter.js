$("#filterContainer .right form select").change((e) => {
    $(e.target).closest("form").submit();
})