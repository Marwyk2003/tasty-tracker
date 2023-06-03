from hashlib import sha256


class Login:
    def __init__(self, db):
        self.db = db

    def hash_pswd(self, passwd):
        m = sha256()
        m.update(passwd.encode('utf-8'))
        print(m.hexdigest(), flush=True)
        return m.hexdigest()

    def login(self, login, passwd):
        hashed = self.hash_pswd(passwd)
        uid = self.db.exec(
            f'''
                SELECT * from login('{login}', '{hashed}');
            '''
        )[0][0]
        return uid
