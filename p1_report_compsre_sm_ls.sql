Select *
From Sourcingmetric Sm, Udt_Llamasoft_Data Ls
Where Sm.Item=Ls.Item(+)
And Sm.Source=Ls.Source(+)
And Sm.Dest=Ls.Dest(+)
and ls.dest is not null
order by sm.item, sm.dest asc, sm.source