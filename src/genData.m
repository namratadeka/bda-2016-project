data = zeros(500,11);
for c = 1:10
    data(:,c) = round(rand(1,500))';
end
data(:,11) = xor(data(:,9),data(:,10));
sdata = data;
tree = fitctree(data(:,1:10),data(:,11));
view(tree,'mode','graph');
F = zeros(10,1);
for t=1:5
    fav = round(rand(1,10))';
    for c = 1:500
        w = 1;
        for v = 1:10
            if data(c,v) == fav(v,1)
                w = w*2;
            end
        end
        new = zeros(w-1,11);
        for n = 1:w-1
            new(n,:) = data(c,:);
        end
        sdata = [sdata; new];
    end
    stree = fitctree(sdata(:,1:10),sdata(:,11));
    view(stree,'mode','graph');
    v = strsplit(stree.CutPredictor{1},'x');
    x = str2double(v{2});
    F(x,1) = F(x,1) + 1;
    v = strsplit(stree.CutPredictor{2},'x');
    x = str2double(v{2});
    F(x,1) = F(x,1) + 1;
end
[m,i] = max(F);
if m>0
    disp(i);
    F(i) = 0;
    [m,i] = max(F);
    if m>0
        disp(i);
    end
else
    disp(-1);
end
