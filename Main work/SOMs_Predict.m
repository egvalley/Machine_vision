function test_pred=SOMs_Predict(tes_PCA,tes_label,weights,weights_label)

    % Make the prediction based on the Semantic map
    for i=1:size(tes_PCA,2)
        [~, bmu] = min(sum((weights - tes_PCA(:,i)).^2)); % Find the best matching unit (BMU)
        test_pred(i)=weights_label(bmu);% Predict the possible label
    end

    Accuracy(test_pred,tes_label,6);

    % the evaluation function
    function Accuracy(test_pred,tes_label,label_num)
        % Test recording array for recording the sucessful predictions
        test_re_ar=zeros(1,label_num);
        % Record each sucessful prediction
        for i=1:length(test_pred)
            if test_pred(i)==tes_label(i) && test_pred(i)=='1'
                test_re_ar(1)= test_re_ar(1)+1;
            end
            if test_pred(i)==tes_label(i) && test_pred(i)=='2'
                test_re_ar(2)= test_re_ar(2)+1;
            end
            if test_pred(i)==tes_label(i) && test_pred(i)=='3'
                test_re_ar(3)= test_re_ar(3)+1;
            end
            if test_pred(i)==tes_label(i) && test_pred(i)=='A'
                test_re_ar(4)= test_re_ar(4)+1;
             end
            if test_pred(i)==tes_label(i) && test_pred(i)=='B'
                test_re_ar(5)= test_re_ar(5)+1;
            end
            if test_pred(i)==tes_label(i) && test_pred(i)=='C'
                test_re_ar(6)= test_re_ar(6)+1;
            end
        end   
    
        % Calculate the accuracy and Display the accuracy
        disp("============test");
        accuracy = sum(test_re_ar)/length(test_pred);
        Z=['Accuracy ',num2str(accuracy)];
        disp(Z);
        for i=1:label_num
            X=['there are ',num2str(test_re_ar(i)), ' successful predictions of label No. ', num2str(i)];
            disp(X);
        end
    
    end
end