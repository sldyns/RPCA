function [U,V]=PCA(X, Score, method)

X = double(X);
[m,n] = size(X);


if method == 1
    X_mean = mean(X,1); % 按列对各分量求均值
    X_meansub = X - repmat(X_mean,m,1); % 中心化（零均值化）
    Cov_X = X_meansub'*X_meansub/(m-1); % X^'*X^/(m-1) 即为协方差矩阵
    [V_f, D_f] = eig(Cov_X); % 特征值分解
    [V_s, D_s] = eigsort(V_f, D_f); % 排列特征值与特征向量
    V_n = normc(V_s); % 标准化特征向量
    
    sum_D = sum(abs(D_s(:)));
    score = 0;
    K = min(m,n);
    for i=1:min(m,n)
        score = score + abs(D_s(i,i))/sum_D;
        if score > Score
            K = i;
            break
        end
    end
    
    V = V_n(:,1:K)';
    U = X_meansub*V'*V + repmat(X_mean,m,1);
    
elseif method == 2
    
    
    [u,s,v] = svd(double(X));
    
    sum_s = sum(s(:));
    score = 0;
    
    K = min(m,n);
    for i=1:min(m,n)
        score = score + s(i,i)/sum_s;
        if score >0.8
            K = i;
            break
        end
    end
    
    V = v(:,1:K)';
    U = u(:,1:K) * s(1:K,1:K)  * V;
else
    disp('方法错误');

end

end
