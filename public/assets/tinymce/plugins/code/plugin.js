tinymce.PluginManager.add("code",function(e){function t(){e.windowManager.open({title:"Source code",body:{type:"textbox",name:"code",multiline:!0,minWidth:600,minHeight:500,value:e.getContent({source_view:!0}),spellcheck:!1},onSubmit:function(t){e.setContent(t.data.code)}})}e.addButton("code",{icon:"code",tooltip:"Source code",onclick:t}),e.addMenuItem("code",{icon:"code",text:"Source code",context:"tools",onclick:t})});