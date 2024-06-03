#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QSqlDatabase>
#include <QObject>
#include <QSql>
#include <QDebug>
#include <QSqlQueryModel>

class ListModel : public QSqlQueryModel
{
    Q_OBJECT
private:
    bool filter = false;
    QString filterString;

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        PlayerRole,
        ScoreRole,
    };
    explicit ListModel(QObject *parent = 0);
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

protected:
    QHash<int, QByteArray> roleNames() const override;

public slots:
    void updateModel();
    int getId(int row);
};

#endif // LISTMODEL_H
