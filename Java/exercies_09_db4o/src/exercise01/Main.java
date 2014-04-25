package exercise01;
import java.io.File;

import com.db4o.Db4oEmbedded;
import com.db4o.ObjectContainer;
import com.db4o.ObjectSet;
import com.db4o.config.EmbeddedConfiguration;

public class Main {
	private final static String DB4OFILENAME = "database.db4o";

	public static void main(String[] args) {
		new File(DB4OFILENAME).delete();
		EmbeddedConfiguration config = Db4oEmbedded.newConfiguration();
		ObjectContainer db = Db4oEmbedded.openFile(config, DB4OFILENAME);

		try {
			Angestellter ang1 = new Angestellter(1, "some dude", 4200);
			db.store(ang1);
			Angestellter ang2 = new Angestellter(2, "lol cat", 4500);
			db.store(ang2);

			listAngestellte(db);

			ObjectSet<Angestellter> result = db.queryByExample(new Angestellter(2, null, 0));
			Angestellter found = result.next();
			found.setSalaer(5100);
			db.store(found);

			listAngestellte(db);

			result = db.queryByExample(new Angestellter(1, null, 0));
			found = result.next();
			db.delete(found);

			listAngestellte(db);
		} finally {
			db.close();
		}
	}

	private static void listAngestellte(ObjectContainer db) {
		ObjectSet<Angestellter> result = db.query(Angestellter.class);
		System.out.println("Result size: " + result.size());
		for (Angestellter shard : result) {
			System.out.println(shard);
		}
	}
}
