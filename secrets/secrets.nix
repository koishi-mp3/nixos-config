let
  cirno = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK52RsQVAT+Iak6Exy1AYpykvSuc91V6km++NaQiaz+W cirno@blahaj";
  users = [ cirno ];
in
{
  "nas.age".publicKeys = users;
}
