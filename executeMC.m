function a = executeMC(pars,data)
a = [];

Yt = convertY(data.train.y);
%Y = data.train.y;
Xt = data.train.data.';

mdl = pars.fitfun(Xt,Yt);
classt = predict(mdl,Xt);

%%%% this seems suboptimal, but to compare with the other results we will do
%%%% it
CCt = deconvert(classt, data.train.y);
%figure
%plotconfusion(data.train.y, CC) %%% for KNN with K = 1, this is 100%...

%%%%% now test validation data

%Yv = convertY(data.val.y);
Xv = data.val.data.';
classv = predict(mdl,Xv);
CCv = deconvert(classv, data.val.y);

figure
plotconfusion(data.val.y, CCv, pars.name ) %%% for KNN with K = 1, this is 100%...

%%%% making mt

a.mt.conffig = {data.train.y, CCt,[ pars.name 'train'], data.val.y, CCv, [pars.name 'val'] };
[~, a.mt.confusions.val, ~, a.mt.per.val] = confusion(data.val.y, CCv);
[~, a.mt.confusions.train, ~, a.mt.per.train] = confusion(data.train.y, CCt);

%IDX = knnsearch(Xt,Xv,'K',pars.numneighbours);
a.mdl = mdl;
a.IDX = eval(pars.postclassmethod);

%disp('Hello!')

end
function Y = convertY(y)
labels = {'1','2','3','4','5','6','7','8','9','10','11','12'};
for i = 1: size(y,2)
    Y(i) = labels(logical(y(:,i)));
end
end
function CC = deconvert(class, y)
CC = zeros(size(y));
for i = 1:size(class,1)
    CC(str2double(class(i)),i) = 1;
end

end