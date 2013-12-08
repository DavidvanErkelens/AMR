load 'BlobSignaturesTestSet.mat';
load 'BlobSignaturesTrainSet.mat';


szX = size(S_storeTestSet, 2);
szY = size(S_storeTrainSet, 2);
confusion = zeros(szX, szY);


for i = 1:szX
	for j = 1:szY
        length = length(S_storeTrainSet{i});
        confusion(j,i) = ((length - LevenshteinDistance(S_storeTrainSet{i}, S_storeTestSet{j})) / length) * 100;
	end
end

% plot confusion matrix
figure;
colormap('gray')
imagesc(confusion);

