// Shared TinyMCE initialization for Exchange mailbox auto-reply editor fields.
$(document).ready(function () {
    tinymce.init({
        selector: ".tinymce",
        directionality: document.documentElement.dir === "rtl" ? "rtl" : "ltr",
        plugins: ["active_directory advlist autolink lists link image charmap preview hr anchor pagebreak searchreplace htmlchar_count visualblocks visualchars code fullscreen insertdatetime media nonbreaking save table contextmenu directionality template paste textcolor colorpicker textpattern imagetools codesample"],
        toolbar: false,
        elementpath: false,
        custom_undo_redo_levels: 10,
        height: 250,
        max_chars: 8000,
        content_style: ".mce-content-body {font-size:12pt;font-family:Calibri,Arial,Helvetica,sans-serif;}",
        menu: {
            edit: { title: "Edit", items: "undo redo | cut copy paste pastetext | selectall" },
            insert: { title: "Insert", items: "template active_directory | media image link | hr charmap" },
            view: { title: "View", items: "visualaid" },
            format: { title: "Format", items: "bold italic underline strikethrough superscript subscript | formats | removeformat" },
            table: { title: "Table", items: "inserttable tableprops deletetable | cell row column" },
            tools: { title: "Tools", items: "code preview" }
        },
        toolbar1: "undo redo | bold italic underline | forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media | ltr rtl",
        templates: [{}]
    });
});