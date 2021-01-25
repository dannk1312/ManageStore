using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManageStore.Models;

namespace ManageStore.Controllers
{
    public static class DataProvider
    {
        private static DB_ManageStoreEntities db;
        public static DB_ManageStoreEntities DB
        {
            get { if (db == null) db = new DB_ManageStoreEntities(); return db; }
            set { if (db != null) db.Dispose();  db = value; }
        }

        public static void ReloadData()
        {
            db = new DB_ManageStoreEntities();
        }
    }
}
