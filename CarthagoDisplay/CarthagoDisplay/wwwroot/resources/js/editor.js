editors = {};


function CustomUploadAdapterPlugin(editor) {
    editor.plugins.get("FileRepository").createUploadAdapter = (loader) => {
        return new UploadAdapter(loader);
    };
}

function CreateEditor(editorId, defaultValue, height, dotNetReference) {

    ClassicEditor
        .create(document.getElementById(editorId),
            {
                extraPlugins: [CustomUploadAdapterPlugin],
                toolbar: {
                    items: [
                        "heading",
                        "|",
                        "fontFamily",
                        "fontSize",
                        "fontColor",
                        "fontBackgroundColor",
                        "highlight",
                        "alignment",
                        "bold",
                        "italic",
                        "bulletedList",
                        "numberedList",
                        "removeFormat",
                        "specialCharacters",
                        "horizontalLine",
                        "|",
                        "outdent",
                        "indent",
                        "|",
                        "imageUpload",
                        "blockQuote",
                        "insertTable",
                        "mediaEmbed",
                        "htmlEmbed",
                        "code",
                        "codeBlock",
                        "imageInsert",
                        "|",
                        "findAndReplace",
                        "undo",
                        "redo",
                        "sourceEditing"
                    ]
                },
                language: "nl",
                image: {
                    toolbar: [
                        "imageTextAlternative",
                        "imageStyle:inline",
                        "imageStyle:block",
                        "imageStyle:side"
                    ]
                },
                table: {
                    contentToolbar: [
                        "tableColumn",
                        "tableRow",
                        "mergeTableCells",
                        "tableCellProperties",
                        "tableProperties"
                    ]
                },
                licenseKey: "",


            })
        .then(editor => {

            editors[editorId] = editor;

            editor.setData(defaultValue);

            editor.editing.view.change(writer => {

                writer.setStyle("height", "100vh", editor.editing.view.document.getRoot());


                document.getElementById(editorId).parentElement.height = "100%";
                document.getElementById(editorId).parentElement.parentElement.height = "100%";
                document.getElementById(editorId).parentElement.parentElement.parentElement.height = "100%";

            });


            editor.model.document.on("change:data",
                () => {

                    let data = editor.getData();

                    dotNetReference.invokeMethodAsync("OnEditorChanged", data);

                });

        })
        .catch(error => {

            console.error(error);

        });


}


function DestroyEditor(editorId) {

    editors[editorId].destroy().then(() => delete editors[editorId])
        .catch(error => console.log(error));


}