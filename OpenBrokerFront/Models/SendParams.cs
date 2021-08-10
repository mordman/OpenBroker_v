using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel;

namespace OpenBrokerFront.Models
{
    public class SendParams
    {
        [Description("Дата с")]
        public DateTime From { get; set; }
        [Description("Дата по")]
        public DateTime To { get; set; }
        [Description("Тип")]
        public int OutType { get; set; }
    }
}
