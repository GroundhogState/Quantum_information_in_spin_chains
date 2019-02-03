function data = rec_getfield(struct, fields)

    if iscell(fields)
        substruct = getfield(struct, fields{1});
        data = rec_getfield(substruct,fields{2:end});  
    else
        data = getfield(struct, fields);
    end

end