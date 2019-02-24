function loop_data = dir_loop_import(config)
    datapath = config.L.savepath;
    subdirs = dir(fullfile(datapath,'L=*'));
    num_dirs = numel(subdirs);
    loop_data = cell(num_dirs,1);
    for dir_idx = 1:num_dirs
        subdir = subdirs(dir_idx).name;
        files = dir(fullfile(datapath,subdir,'*.mat'));
        if ~isnan(config.L.num_files)
            num_files = config.L.num_files;
        else
            num_files = size(files,1);
        end
%         dir_data = cell(numel(subdir,1));    
        fprintf('\n Importing %6.f files from dir %u/%u:\n000000',num_files,dir_idx,num_dirs)
        for N=1:num_files
            if mod(N,100) ==0
                fprintf('\b\b\b\b\b\b%06.f',N)
            end
            fname = files(N).name;
            fname = fullfile(datapath,subdir,fname);
            data = load(fname);
        end % loop over files
        loop_data{dir_idx} = data;
    end % loop over dirs
end