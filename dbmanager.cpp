#include "dbmanager.h"

DBManager::DBManager(QObject *parent)
    : QObject{parent}
{}

DBManager::~DBManager(){}

void DBManager::connectToDataBase()
{
    if(!QFile(WAY_TO_DATABASE).exists()){
        qDebug() << "Файла БД нет!";
    } else {
        this->openDataBase();
    }
}

bool DBManager::openDataBase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName(DATABASE_HOSTNAME);
    db.setDatabaseName(WAY_TO_DATABASE);
    if(db.open()){
        return true;
    } else {
        return false;
    }
}

void DBManager::closeDataBase()
{
    db.close();
}

bool DBManager::checkUser(const QString &user, const int &score)
{
    QSqlQuery query;

    query.prepare("SELECT user FROM Users WHERE user = ? and score < ?;");
    query.bindValue(0, user);
    query.bindValue(1, score);

    if(!query.exec() || !query.next()){
        return false;
    }
    return true;
}

bool DBManager::insertIntoTable(const QString &user, const int &score)
{
    QSqlQuery query;

    query.prepare("INSERT INTO Users(user, score) VALUES (?, ?)");

    query.bindValue(0, user);
    query.bindValue(1, score);

    if(!query.exec()){
        qDebug() << "error insert into " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }
    return true;
}

bool DBManager::updateRecord(const QString &user, const int &score)
{
    QSqlQuery query;

    query.prepare("UPDATE Users SET score = ? WHERE user = ?;");

    query.bindValue(0, score);
    query.bindValue(1, user);

    if(!query.exec()){
        qDebug() << "error update " << TABLE;
        qDebug() << query.lastError().text();
        return false;
    }

    return true;
}
