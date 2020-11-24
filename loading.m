function d = loading(loadingtext, fig)
    d = uiprogressdlg(fig, 'Title', loadingtext, ...
        'Indeterminate', 'on');
    drawnow;
end