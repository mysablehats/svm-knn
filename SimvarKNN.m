classdef SimvarKNN < Simvar
    properties
        pars
    end
    methods
        function simvar = SimvarKNN(varargin)
            %% Object Initialization %%
            % Call superclass constructor before accessing object
            % You cannot conditionalize this statement
            simvar = simvar@Simvar(varargin{:});
            
            %% Post initialization
            simvar.method = 'knearest';
            simvar.excfun = @(data,ii)executeknn(simvar(ii).pars, data); %useless to set here, since arq_connect is empty!
            simvar.PARA = 0; % im testing now
        end
        
    end
end