#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QDebug>

#define DATABASE_HOSTNAME   "NameDataBase"
#define DATABASE_NAME       "lab17.db"
#define WAY_TO_DATABASE     "C:\\Users\\shura\\Documents\\LAB17\\lab17.db"
#define TABLE   "Users"

class DBManager : public QObject
{
    Q_OBJECT
public:
    explicit DBManager(QObject *parent = nullptr);
    ~DBManager();
    void connectToDataBase();

signals:

private:
    QSqlDatabase  db;

    bool openDataBase();
    void closeDataBase();
public slots:
    //  Функция checkUser осуществляет поиск в таблице лидеров пользователя с рекордом меньше, чем заработанным во время игры.
    //  Если такой пользователь есть то производится обновление данных updateRecord
    //  иначе будет осуществлена попытка добавления пользователя в функции insertIntoTable.
    //  Если пользователь с уже есть в таблице но не побил свой рекорд,
    //  то изменений не произойдет и в консоли выведется ошибка "error insert into  Users", но она не влияет на игровой процесс.
    bool checkUser(const QString &user, const int &score);
    bool insertIntoTable(const QString &user, const int &score);
    bool updateRecord(const QString &user, const int &score);
};

#endif // DBMANAGER_H
