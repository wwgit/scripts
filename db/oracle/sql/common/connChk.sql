select username,count(username) from v$session where username is not null group by username
