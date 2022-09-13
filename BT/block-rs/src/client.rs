pub use secp256k1::rand::rngs::OsRng;
pub use secp256k1::All;
pub use secp256k1::Secp256k1;

pub mod key {
    pub use secp256k1::PublicKey;
    pub use secp256k1::SecretKey;
}

struct Client {
    pub publickey: key::PublicKey,
    pub privatekey: key::SecretKey,
}

impl Client {
    pub fn new() -> Client {
        let rng = OsRng {};
        let secp = Secp256k1::new();
        let (privatekey, publickey) = secp.generate_keypair(&mut rng);
        Client {
            publickey,
            privatekey,
        }
    }
}
