


class trace9::test{
   file { '/tmp/saqib':
   owner   => 'root',
   group   => 'root',
   mode    => '0644',
   content => "hello, world!\n",
   }


	notify{'Hello Muhammad':}
}
