import pandas as pd
import numpy as np
from collections import Counter
import time
from topic_specific_functions import choose_feature_set
from sklearn.metrics import mean_absolute_error, mean_squared_error, mean_squared_log_error, r2_score
from catboost import CatBoostClassifier


def main():
    import argparse
    parser = argparse.ArgumentParser()

    parser.add_argument('--target', type=str, required=True, help='Target variable')
    parser.add_argument('--iterations', type=int, required=True, help='Num trees')
    parser.add_argument('--depth', type=int, required=True, help='Depth of trees')
    parser.add_argument('--topic', type=str, required=True, help='Feature topic')

    args = parser.parse_args()

    target = args.target
    iterations = args.iterations
    depth = args.depth
    topic = args.topic

    assert iterations > 0
    assert depth > 0

    start = time.time()

    # Prep train and test sets
    df = pd.read_csv("../data/clean_back_pers_soc2.csv")
    print(df.shape)
    print(Counter(df.dtypes))

    # Fix instance with *
    dict_star = {'*': np.nan}
    df.replace(dict_star, inplace=True)

    df2 = df.copy()
    # Drop IDs and cheating features
    df2 = df.drop(['nomem_encr', 'month', 'cs_m', 'cp014',
                   'cp015', 'cp016', 'cp017', 'cp018',
                   'cp038', 'cp068', 'cp076', 'cp080',
                   'cp081', 'cp147', 'cp148', 'cp149',
                   'cp152', 'cp154', 'cp165', 'cs001',
                   'cs002', 'cs070', 'cs283'], axis=1)
    train_set = df2[df2['wave'].isin([1, 2, 3, 4, 5, 6])]
    test_set = df2[df2['wave'].isin([7, 8, 9, 10])]
    print("train obs: ", len(train_set), "test obs: ", len(test_set))

    chosen_features = choose_feature_set(topic=topic)
    print(chosen_features)

    X_train = train_set.filter(chosen_features, axis=1)
    X_test = test_set.filter(chosen_features, axis=1)

    print(X_train.columns)
    print(len(X_train.columns))
    print(len(chosen_features))

    y_train = train_set[target]
    y_test = test_set[target]

    # Fit Catboost model
    model = CatBoostClassifier(iterations=iterations,
                               depth=depth,
                               learning_rate=0.2,
                               loss_function='MultiClass',
                               leaf_estimation_iterations=1,
                               leaf_estimation_method='Newton',
                               task_type='CPU',
                               boosting_type='Plain',
                               logging_level='Silent')

    model.fit(X_train, y_train)
    model.save_model('../results/model_{}_{}_iter{}_depth{}'.format(str(target), str(topic), iterations, depth))
    y_pred = model.predict(X_test)
    print("mean abs error: ", mean_absolute_error(y_test, y_pred))
    print("time: ", time.time() - start)


if __name__ == '__main__':
    main()
