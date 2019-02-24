function import_data = import_dir_data(config,import_function)
% A wrapper for get_network_data
%   TODO: Safety checks
datapath = config.gen.savepath;
subdirs = dir(fullfile(config.gen.savepath,'W=*'));
num_dirs = numel(subdirs);
import_data.W = cell(num_dirs,1);
import_data.net_data = cell(num_dirs,1);
for dir_idx = 1:num_dirs
    subdir = subdirs(dir_idx).name;
    files = dir(fullfile(datapath,subdir,'*.mat'));
    if ~isnan(config.imp.num_files)
        num_files = config.imp.num_files;
    else
        num_files = size(files,1);
    end
    dir_data = cell(numel(subdir,1));    
    fprintf('\n Importing %6.f files from dir %u/%u:\n000000',num_files,dir_idx,num_dirs)
    for N=1:num_files
        if mod(N,100) ==0
            fprintf('\b\b\b\b\b\b%06.f',N)
        end
        fname = files(N).name;
        fname = fullfile(datapath,subdir,fname);
        data = load(fname);
        dir_data{N} = import_function(data);
%         dir_data{N} = get_atomized_data(data);
    end % loop over files
    import_data.W{dir_idx} = str2double(subdir(3:end));
    import_data.net_data{dir_idx} = dir_data; 
end % loop over dirs

end