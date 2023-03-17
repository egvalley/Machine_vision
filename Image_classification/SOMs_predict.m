function Test_pred=SOMs_predict(Test_Data,Test_ClassLabel,weights,weights_label)

    % Make the prediction based on the Semantic map
    for i=1:size(Test_Data,2)
        [~, bmu] = min(sum((weights - Test_Data(:,i)).^2)); % Find the best matching unit (BMU)
        Test_pred(i)=weights_label(bmu);
    end

    accuracy(Test_pred,Test_ClassLabel);

    % the evaluation function
    function accuracy(Test_pred,Test_ClassLabel)
        test_record_array=zeros(1,length(Test_pred));
        for i=1:length(Test_pred)
            if Test_pred(i)==Test_ClassLabel(i)
                test_record_array(i)= test_record_array(i)+1;
            end
        end   
    
        % Calculate the accuracy and Display the accuracy
        disp("============test");
        accuracy = sum(test_record_array)/length(Test_pred);
        Z=['Accuracy ',num2str(accuracy)];
        disp(Z);
        for i=1:length(test_record_array)
            X=['there are ',num2str(test_record_array(i)), ' successful predictions of label ' ,char(Test_ClassLabel(i))];
            disp(X);
        end
    
    end
end