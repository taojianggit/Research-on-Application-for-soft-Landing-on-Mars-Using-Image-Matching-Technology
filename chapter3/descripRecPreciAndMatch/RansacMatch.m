%好难卖旗舰店
function [F,InlierPoints1,InlierPoints2]=RansacMatch(MatchedPoints1,MatchedPoints2)
[F,EpipolarInliers]=estimateFundamentalMatrix(MatchedPoints1,MatchedPoints2,'Method',   'LMedS');%采用RANSAC过滤点
InlierPoints1=MatchedPoints1(EpipolarInliers);%重新获取图像1的匹配点
InlierPoints2=MatchedPoints2(EpipolarInliers);%重新获取图像2的匹配点
end

