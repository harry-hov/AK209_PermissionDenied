

import numpy as np
from sklearn.ensemble import IsolationForest as iForest
from ..utils import metrics

class IsolationForest(iForest):

    def __init__(self, n_estimators=100, max_samples='auto', contamination=0.03, **kwargs):
        """ The IsolationForest model for anomaly detection

        Arguments
   """

        super(IsolationForest, self).__init__(n_estimators=n_estimators, max_samples=max_samples, 
            contamination=contamination, behaviour='new', **kwargs)


    def fit(self, X):
        """
        Auguments
        ---------
            X: ndarray, the event count matrix of shape num_instances-by-num_events
        """

        print('====== Model summary ======')
        super(IsolationForest, self).fit(X)

    def predict(self, X):
        """ Predict anomalies with mined invariants

        Arguments
        ---------
            X: the input event count matrix

        Returns
        -------
            y_pred: ndarray, the predicted label vector of shape (num_instances,)
        """
        
        y_pred = super(IsolationForest, self).predict(X)
        y_pred = np.where(y_pred > 0, 0, 1)
        return y_pred

    def evaluate(self, X, y_true):
        print('====== Evaluation summary ======')
        y_pred = self.predict(X)
        precision, recall, f1 = metrics(y_pred, y_true)
        print('Precision: {:.3f}, recall: {:.3f}, F1-measure: {:.3f}\n'.format(precision, recall, f1))
        return precision, recall, f1

