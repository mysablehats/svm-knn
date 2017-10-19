classdef SimvarMC < Simvar
    properties
        pars
    end
    methods
        function simvar = SimvarMC(varargin)
            %% Object Initialization %%
            % Call superclass constructor before accessing object
            % You cannot conditionalize this statement
            simvar = simvar@Simvar(varargin{:});
            
            simvar.method = '???';
            simvar.pars.postclassmethod = '';            
            simvar.pars.name = 'Some matlab classifier';
            
            %%% for KNN
            simvar.pars.numneighbours = 1000;
            somefun = @fitcknn;
            simvar.pars.fitpars = {'NumNeighbors',simvar.pars.numneighbours};
            simvar.pars.postclassmethod = 'knnsearch(Xt,Xv,''K'',pars.numneighbours);';
            simvar.pars.name = 'KNN';
            simvar.method = 'knn';

            %%% for SVM
            %simvar.method = 'svm';
            somefun = @fitcecoc;
            %simvar.pars.t = templateSVM('Standardize',0,'KernelFunction','gaussian');
            simvar.pars.t = templateSVM('Standardize',0,'KernelFunction','linear');
            simvar.pars.fitpars = {'Learners',simvar.pars.t};
            simvar.pars.name = 'SVM';
            simvar.method = 'svm';
            
            %[ num2str(pars.numneighbours) '-NNval']
            %'SVMval'
            %simvar.pars.svmstuff = 1; %%% remove this!    
            
            %% Post initialization

            simvar.pars.fitfun = @(Xt,Yt)somefun(Xt,Yt,simvar.pars.fitpars{:});
            simvar.excfun = @(data,ii)executeMC(simvar(ii).pars, data); %pars have to be fully defined up to here!
            simvar.PARA = 0; % im testing now
            
            
            
        end
        function [endacc, combinedval] = analyze_outcomes(simvartrial)
            %disp('hello')
            combinedval = zeros(size(simvartrial.metrics(1).val));
            for i =1:length(simvartrial.metrics)
                figure
                plotconfusion(simvartrial.metrics(i).conffig{:})
                combinedval = combinedval + simvartrial.metrics(i).val;
            end
            combinedval = combinedval/length(simvartrial.metrics);
            endacc = sum(diag(combinedval))/sum(sum(combinedval));
        end
    end
end