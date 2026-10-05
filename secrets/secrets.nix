let
  cirno = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK52RsQVAT+Iak6Exy1AYpykvSuc91V6km++NaQiaz+W cirno@blahaj";
  koishi = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICygdXQnGhVo0WT9u8Pw/cZyK3DUPyKHrMec6mfWUNPg koishi@nixstrogen";
  users = [ cirno koishi ];
in
{
  "nas.age".publicKeys = users;
}
