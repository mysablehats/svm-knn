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
            
            
            simvar.pars.numneighbours = 1;
            
            
            %% Post initialization
            simvar.method = 'knearest';
            simvar.excfun = @(data,ii)executeknn(simvar(ii).pars, data); %if pars is empty, this will not work!
            simvar.PARA = 0; % im testing now
            
            
        end
        function [endacc, combinedval] = analyze_outcomes(simvartrial)
            disp('hello')
            for i =1:length(simvartrial.metrics)
                figure
                plotconfusion(simvartrial.metrics(i).conffig{:})
            end
            combinedval = 
        end
    end
end