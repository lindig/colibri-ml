drop database if exists colibri;
create database colibri;
use colibri;

create table if not exists rules
( subject   varchar(128) not null
, version   varchar(128) not null
, rule      varchar(128) not null
, support   int unsigned not null
, primary key (subject, version, rule) 
) ; 

create table if not exists violations
( subject   varchar(128) not null
, version   varchar(128) not null
, rule      varchar(128) not null
, violation varchar(128) not null
, confidence float not null
, support   int unsigned not null
, primary key (subject, version, rule, violation)
) ; 

create table if not exists violators
( rule      varchar(128) not null
, fun       varchar(128) not null
, primary key (rule, fun)
) ; 



