//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ManageStore.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class vw_Person
    {
        public string Name { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }
        public string Password { get; set; }
        public int PersonId { get; set; }
        public Nullable<int> RoleId { get; set; }
        public Nullable<int> CityId { get; set; }
        public string City { get; set; }
        public string Role { get; set; }
    }
}