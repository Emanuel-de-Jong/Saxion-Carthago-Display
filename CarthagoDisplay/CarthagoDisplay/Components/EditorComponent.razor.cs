using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;

namespace CarthagoDisplay.Components
{
    partial class EditorComponent : IDisposable
    {
        private string _editorId;
        [Inject] public IJSRuntime JSRuntime { get; set; }
        [Parameter] public string EditorValue { get; set; }
        [Parameter] public EventCallback<string> EditorValueChanged { get; set; }
        [Parameter] public string EditorHeight { get; set; }

        public string EditorId
        {
            get
            {
                if (string.IsNullOrEmpty(_editorId))
                    _editorId = $"ckeditor_{Guid.NewGuid().ToString().ToLower().Replace("-", "")}";
                return _editorId;
            }
            set => _editorId = value;
        }

        public void Dispose()
        {
            JSRuntime.InvokeVoidAsync("DestroyEditor", EditorId);
        }


        protected override async Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
                await JSRuntime.InvokeVoidAsync("CreateEditor", EditorId, EditorValue, EditorHeight,
                    DotNetObjectReference.Create(this));

            await base.OnAfterRenderAsync(firstRender);
        }


        [JSInvokable]
        public async Task OnEditorChanged(string data)
        {
            await EditorValueChanged.InvokeAsync(data);
        }
    }
}